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
  revision 2
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "aee2e6df42f33af09a6cf13533e19382f7f9ee59654a76789ee4487a386da619"
    sha256 cellar: :any, arm64_tahoe:       "50bb2114d83b13e331582249928e9101626c854e33e3893ae45fc0e97488298a"
    sha256 cellar: :any, arm64_sequoia:     "cf74fc6aa25dcfb4c3607f5c146e7c4b1148b6cac6966b610d2452ef94e9c473"
    sha256 cellar: :any, arm64_linux:       "cab7894190f0eaae9cf62105c051d313250f89b82d06c04f9be64bf23ee7286b"
    sha256 cellar: :any, x86_64_linux:      "e2466162c5cac795e135c3ae8eba775658f4b5939194d482fb0781551b003d4d"
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
