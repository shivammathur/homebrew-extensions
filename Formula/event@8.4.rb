# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT84 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.4.tgz"
  sha256 "5c4caa73bc2dceee31092ff9192139df28e9a80f1147ade0dfe869db2e4ddfd3"
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "8f5c05481353a72f4e1a4bcce6e3cc8893319d05a98560bed3407afb93447475"
    sha256 cellar: :any,                 arm64_sonoma:  "addc38d0e2f034bbf5632b95a21c50ad98d83f9f7f6de4b58728d87cff547d35"
    sha256 cellar: :any,                 arm64_ventura: "d39cb6b9e02a2feafdf30e22034929d1a400ca48f2cb79689ad8fcf5935d8a3e"
    sha256 cellar: :any,                 ventura:       "9310ce34a568e4bad80dd8b8478b01665cab2e39366a1edcb67114282d8dc6be"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "48e0d4c3b490efe40e062658dfb91598b5bf05afec4ff36dde2595d0fb8f1f24"
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
