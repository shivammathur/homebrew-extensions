# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT85 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.4.tgz"
  sha256 "5c4caa73bc2dceee31092ff9192139df28e9a80f1147ade0dfe869db2e4ddfd3"
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "b997107e76e387b47d642a485d11287060557e0b556290cb25168ef9192d0506"
    sha256 cellar: :any,                 arm64_sonoma:  "dfa2c455feede8cd20ebdd399fe82b74607d328249cc08de9d4ce0c779f74fad"
    sha256 cellar: :any,                 arm64_ventura: "b865c99814b0cf2809ac9772ccba383f0add0a23d2c25fd7a56042011ba03710"
    sha256 cellar: :any,                 ventura:       "9b58742575af62dbab133ce16291445ae42d62e71a6d63ed9e567fc57bd5529b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "66912f1c88d5a44ab05a5722e32266a427e6409bc6762040ef5fdecb8badb79a"
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
