# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT85 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git", branch: "6.x"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "cc7baf3ac26528c0e778fbc0eb907f0f72012e8eab973ca7ca81554b6f1604a4"
    sha256 cellar: :any,                 arm64_sonoma:  "f4b24d93acf9bb53eb515914fb650763118c7b1bf537d035cc47b8c13324987e"
    sha256 cellar: :any,                 arm64_ventura: "de9cb3035b029fdb606e4f5b2cabf761409710fdf9e012a3ab3b3e027f0db3fd"
    sha256 cellar: :any,                 ventura:       "4dc0fa8feff70cf2d42b94aca32d55460d90c39c702029e8cfd091f1aed422a5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5b3bbf4075a36a0c8a57dfedae41e138e423bc2b89cd0744b83018f1de30653c"
  end

  depends_on "librdkafka"

  def install
    Dir.chdir "rdkafka-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-rdkafka=#{Formula["librdkafka"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
