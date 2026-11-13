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
    sha256 cellar: :any, arm64_golden_gate: "b9f773f142dee811d72ef12688132dd35d8d29a6bf8051dd7a0d1bb3032a43c3"
    sha256 cellar: :any, arm64_tahoe:       "e637ba416107e12852c6e1adc331c0088606d87abaa161cc7e73d1deea9f3bed"
    sha256 cellar: :any, arm64_sequoia:     "acdcd969567046ad010207e04c74ce35821891408422bb673fc47997d3039739"
    sha256 cellar: :any, arm64_linux:       "3cc05c8737370a1fa1f099b239765d495a59ac526ab1769bea4116f8142e8d4c"
    sha256 cellar: :any, x86_64_linux:      "3a1822019fabe0d9ed392e823795aa800a434a831cd6064230b8921595c3a82a"
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
