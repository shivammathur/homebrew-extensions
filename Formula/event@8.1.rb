# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT81 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.4.tgz"
  sha256 "5c4caa73bc2dceee31092ff9192139df28e9a80f1147ade0dfe869db2e4ddfd3"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/event/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "8721dd0a3f3551bcd5517c86d6c5a9e3f7c9688271f04be55377774bee9b4226"
    sha256 cellar: :any,                 arm64_sonoma:   "d2cde665cabcb34b28569a3d9bcf82f1cd8c62ac21d561e0d7988019c6ea3fc4"
    sha256 cellar: :any,                 arm64_ventura:  "a735b76f6cc7df863ad772ebcbccc631b09ab3c3732292c79a585717650b00c3"
    sha256 cellar: :any,                 arm64_monterey: "03f2634c2852da8b47c72b6961445e611741fda1637dd8e937e7c70f4e1b2021"
    sha256 cellar: :any,                 ventura:        "4e1e105ced7252d5465a0f5d4e89c2113fa08c98bceab789c0bc98fa0dfd7d15"
    sha256 cellar: :any,                 monterey:       "330ce643cca32e4dccf878318a34657ab609109e7f83acb9b498fcdea0d6b620"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1662686d82a58d37607b964580654363e0be56a748fc8686f81962de666cd433"
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
