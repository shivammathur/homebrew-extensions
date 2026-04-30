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
  revision 1
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_tahoe:   "268ebf08e00850d650181e6d3a691ac8e9e99d893941fea35f9318e42cbdf596"
    sha256 cellar: :any,                 arm64_sequoia: "e2f8a04b4bcda48d2ab16b695457014efff1822cacec8956d20b83e5f3d0833a"
    sha256 cellar: :any,                 arm64_sonoma:  "27514b3ca366bb2a56fa7255d574b78db8c842835eed3ef3bcfd62c03eca744b"
    sha256 cellar: :any,                 sonoma:        "12baaa7fa651daf2c8f71ccc61afd23c865b064f2bea6510bd1dcca71f73cb6b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "671185fa4926968b2f888a65d13cef9742edd0f38d7cc968e2c5e9c7915d8cc4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0405612af5cd4691af2d99340d632b06e0c898826ec4c44e4b8de707c2773984"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
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
