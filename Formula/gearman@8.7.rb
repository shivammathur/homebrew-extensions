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
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "faf9a4321eacc9b7b21133e5fafeb14acf5230cf4edaba154f213de7cae1a1ae"
    sha256 cellar: :any, arm64_tahoe:       "e72a05e9dd1736057a53f0bad76f8f9fefc5c1c25c3de1d8e333c772e4c4482b"
    sha256 cellar: :any, arm64_sequoia:     "e124f616f32ec60a16085e767ca90dd49a87818389e24641bfe5173926d86e9a"
    sha256 cellar: :any, arm64_linux:       "c8cfc4b1541837c86f9a8f7480c1ddc8089c9c3a12e5491c7688010ec0856cfa"
    sha256 cellar: :any, x86_64_linux:      "ed48d7315baba84cba13c1209e74d8dbff911b22637b4eb1451e8bcd263af5d6"
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
