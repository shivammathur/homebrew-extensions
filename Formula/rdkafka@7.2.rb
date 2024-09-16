# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT72 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "5cc61d37b554d1943a40dd2d80e5b751e0d2dc2bff246d75618a2be3b14c7dad"
    sha256 cellar: :any,                 arm64_ventura:  "e217124d10cca126ba12cd4232abdb6d28ff4e8bd8f2ca2b193a2ed577c522da"
    sha256 cellar: :any,                 arm64_monterey: "4b40f7ebe170f491fcf4b0dfbd8f6e251dc5d1a9186fbd6c8380727911eaea6c"
    sha256 cellar: :any,                 arm64_big_sur:  "6b82588141dd496082d7fa8bf02d3df0542ba23f29e8890791da4211bc7211ec"
    sha256 cellar: :any,                 ventura:        "57c5a396fd88b7818045a64b65102b0e8bb1c2d403b5748e5ef5c33b9439b9ee"
    sha256 cellar: :any,                 monterey:       "231d112be554ce22217e24d8b48625efb35bb646a24ed8b402ef6f2d028ed021"
    sha256 cellar: :any,                 big_sur:        "6b94d9f2e3e976af0cd6511fb192bc21329552f091280534f316c9b0e4b703be"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "732b1f59a96a9e8d29b9efec541a32f7219f3dd1374d56e719215338c4cd7a07"
  end

  depends_on "librdkafka"

  def install
    Dir.chdir "rdkafka-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-rdkafka=#{Formula["librdkafka"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
