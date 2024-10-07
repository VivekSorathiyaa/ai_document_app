import 'package:ai_document_app/model/plan_model.dart';
import 'package:get/get.dart';

class PlanController extends GetxController {
  RxBool isMonthlySelect = true.obs;
}

RxList<PlanModel> planList = <PlanModel>[
  PlanModel(
      id: 0,
      price: '19',
      isMonthly: true,
      isPopular: false,
      name: 'Starter',
      description: 'Unleash the power of automation.',
      features: [
        'Multi-step Zap',
        'Unlimited Premium ',
        'Unlimited Users Team',
        '',
        '',
      ]),
  PlanModel(
      id: 1,
      price: '54',
      isMonthly: true,
      isPopular: false,
      name: 'Professional',
      description: 'Advanced tools to take your work to the next level.',
      features: [
        'Multi-step Zap',
        'Unlimited Premium',
        'Unlimited Users Team',
        'Shared Workspace',
        '',
      ]),
  PlanModel(
      id: 2,
      price: '89',
      isMonthly: true,
      isPopular: true,
      name: 'Company',
      description: 'Automation plus enterprise-grade features.',
      features: [
        'Multi-step Zap',
        'Unlimited Premium',
        'Unlimited Users Team',
        'Advanced Admin',
        'Custom Data Retention',
      ]),
].obs;
