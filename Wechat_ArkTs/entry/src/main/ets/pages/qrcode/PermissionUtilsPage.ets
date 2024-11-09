import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl';
import common from '@ohos.app.ability.common';

export async function requestPermission(permission: Permissions): Promise<boolean> {
  const context = getContext() as common.UIAbilityContext;
  const atManager = abilityAccessCtrl.createAtManager();

  try {
    // 检查权限是否已经被授予
    const result = await atManager.checkAccessToken(context.applicationInfo.accessTokenId, permission);
    if (result == abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
      return true;
    }

    // 如果权限未被授予，请求权限
    const grantStatus = await atManager.requestPermissionsFromUser(context, [permission]);
    return (grantStatus[0] == abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED);
  } catch (error) {
    console.error(`Failed to request permission ${permission}: `, error);
    return false;
  }
}
