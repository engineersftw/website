if Rails.env.production?
  STRIPE_SUPPORT_PLANS=[
    {
      id: "supporter_tiers",
      title: "Monthly contribution",
      label: "Supporter Tiers (Monthly)",
      payment_options: [
        { label: "SG$ 5 monthly — Bronze Tier", stripe_code: "plan_GWjY7EQuXhQqWb" },
        { label: "SG$ 10 monthly — Silver Tier", stripe_code: "plan_GWjYVhBq11j57I"},
        { label: "SG$ 25 monthly — Gold Tier", stripe_code: "plan_GWjYk4VbCUN7Ga" },
        { label: "SG$ 50 monthly — Platinum Tier", stripe_code: "plan_GWjYzoPnJvGTyq" },
      ]
    },
    {
      id: "one_time_support",
      title: "One time contribution",
      label: "One time show of support",
      payment_options: [
        { label: "SG$ 50 — Pat on the back", stripe_code: "sku_GWjbX21LISiPZr" },
        { label: "SG$ 150 — Awesome Job", stripe_code: "sku_GWjbGAApDV33Vg" },
        { label: "SG$ 300 — True Believer", stripe_code: "sku_GWjcmedr62MBiF" },
        { label: "SG$ 800 — Shining glory of the community", stripe_code: "sku_GWjcXSMNeTFIF7" },
        { label: "SG$ 1500 — OMG! Thank you!", stripe_code: "sku_GWjcgKL4GURrtF" },
      ]
    }
  ]
else
  STRIPE_SUPPORT_PLANS=[
    {
      id: "supporter_tiers",
      title: "Monthly contribution",
      label: "Supporter Tiers (Monthly)",
      payment_options: [
        { label: "SG$ 5 monthly — Bronze Tier", stripe_code: "plan_GVKLZzYhjtOlm5" },
        { label: "SG$ 10 monthly — Silver Tier", stripe_code: "plan_GVKKkHZnwb6OlA"},
        { label: "SG$ 25 monthly — Gold Tier", stripe_code: "plan_GVKMyNkveqCIYQ" },
        { label: "SG$ 50 monthly — Platinum Tier", stripe_code: "plan_GVKM9TWVewLF3j" },
      ]
    },
    {
      id: "one_time_support",
      title: "One time contribution",
      label: "One time show of support",
      payment_options: [
        { label: "SG$ 50 — Pat on the back", stripe_code: "sku_GVKNXbIUvf7FU5" },
        { label: "SG$ 150 — Awesome Job", stripe_code: "sku_GVKP5tb2FK8lYF" },
        { label: "SG$ 300 — True Believer", stripe_code: "sku_GVKP28DHB39hJW" },
        { label: "SG$ 800 — Shining glory of the community", stripe_code: "sku_GVKQi0DQVZkvBw" },
        { label: "SG$ 1500 — OMG! Thank you!", stripe_code: "sku_GVKQxT6fummzTu" },
      ]
    }
  ]
end
