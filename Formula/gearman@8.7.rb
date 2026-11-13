# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT87 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.2.1.tgz"
  sha256 "b9f826c90c87e6abd74cc3a73132c025c03e4bd2ae4360c4edc822ff651d694d"
  revision 2
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "272c1257f9f44858e6e9e3be0410f41b3d6982159a5d7b099383248e37877084"
    sha256 cellar: :any, arm64_tahoe:       "c972f3c197d59ef246400f045bce203ada403e560bdd4b934e4f4e50b167ca66"
    sha256 cellar: :any, arm64_sequoia:     "ed74dfaa233b42a0af4510f5e520d487b93602729fcfe839d9dd533398124915"
    sha256 cellar: :any, arm64_linux:       "2f8a6235064c51ad68208cf0a3be068dcca07e4fade64fbcb5fab12ce8f2cf41"
    sha256 cellar: :any, x86_64_linux:      "9b57bb9d741f4a7dda649f4058a9564476bf4b95d0c9a5cde2e004188bd2c0bb"
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
