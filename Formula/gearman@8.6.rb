# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT86 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.2.1.tgz"
  sha256 "b9f826c90c87e6abd74cc3a73132c025c03e4bd2ae4360c4edc822ff651d694d"
  revision 3
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "a3c0f8edfc126faf1a6b4d375c9c0aff14cd454b333277d656fb64b31b562a53"
    sha256 cellar: :any, arm64_tahoe:       "b7faea0a8430def412624434db46f05d737a86990ef859d2f43c895efaaa89bf"
    sha256 cellar: :any, arm64_sequoia:     "2dcef1a03391cd58b75667c0ddcb7fb51eb18cdae5ebf875082eed1cbd9c53b6"
    sha256 cellar: :any, arm64_linux:       "34f8f9ba4291f708393ba8549c2aed83f8d96e75f9afa0593a0508369939b352"
    sha256 cellar: :any, x86_64_linux:      "4555231dde710290368d4f0b630e60d3f5ad225d68c7c50afa03e7795dfc1343"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Utils::Path.formula_opt_prefix("gearman")}
    ]
    Dir.chdir "gearman-#{version}"
    if File.read("php_gearman.c").include?("zend_exception_get_default()")
      inreplace("php_gearman.c") { |s| s.gsub! "zend_exception_get_default()", "zend_ce_exception" }
    end
    inreplace %w[
      php_gearman.c
      php_gearman_client.c
      php_gearman_job.c
      php_gearman_task.c
      php_gearman_worker.c
    ], "XtOffsetOf", "offsetof"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
