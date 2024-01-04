# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT84 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.1.tgz"
  sha256 "d028f0654f83e842cb54a7530942363a526fb0da439771c7a052de6821c381ea"
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "d985c001a87984cbb66ad9cfeefd545a1f21e3f1b089828605a58348c0148453"
    sha256 cellar: :any,                 arm64_ventura:  "a7dc98ba56ac26c0a812b7efcf969a6a2d97c66a0e364e5118e163ed5795a437"
    sha256 cellar: :any,                 arm64_monterey: "2f96a07d6366cdd15450d5a0d16067487ba808353dd8ced57173ee9d95fa6272"
    sha256 cellar: :any,                 ventura:        "0ca2ab806fef2675dac8535dd0d146e6023d193e85c1fd4b24dc21fef2f66421"
    sha256 cellar: :any,                 monterey:       "29bd045b4a7f6ed8a6e87ee47ff7b1bc268d2ba0249974900554cd659c209e5d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "67ba2c293e5e1288d2f2bb8d6b21fa8f1fc589951274e85b494a72952717dd2e"
  end

  depends_on "libevent"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-event-core
      --with-event-extra
      --with-event-openssl
      --enable-event-sockets
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
      --with-event-libevent-dir=#{Formula["libevent"].opt_prefix}
    ]
    Dir.chdir "event-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
