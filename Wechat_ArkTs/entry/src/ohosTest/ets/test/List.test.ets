import ChatPageTest from './ChatPage.test'
import MomentPageTest from './MomentPage.test'
import abilityTest from './Ability.test'

export default function testsuite() {
  abilityTest()
  MomentPageTest()
  ChatPageTest()
}