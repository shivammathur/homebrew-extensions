# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT83 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git", branch: "6.x"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "27a50bf05b955ee1053dc9cf1fbee4ced89816430e21e68a42504bbaed208711"
    sha256 cellar: :any,                 arm64_big_sur:  "e1c0211aed929b305002b28e6b8765e1be728d0dc0c60bb0f72155b39fb3f8b4"
    sha256 cellar: :any,                 ventura:        "b4b7058e267eaa67bb6dd724a0cbb7ceb2f5b0ad33bea133abaa031f806630e2"
    sha256 cellar: :any,                 monterey:       "8da57f8c7e4724a822e0a552ca7ac5fe0c4c30e6d50ece09ae271489d7590886"
    sha256 cellar: :any,                 big_sur:        "ca02a85cee9148e06a7acaf215a1d431feb89d35594e13fc26d85c54caf85a74"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8cbd0ca4140e1cb51ed8dd3548c5905da527b020bbd087047bcb424a02188b9c"
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
