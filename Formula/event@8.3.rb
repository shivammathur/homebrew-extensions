# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT83 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.2.tgz"
  sha256 "2de4f45ddea90da53fe0a811016e421b4d2e4d148d4ba2f90c19ac2494c23339"
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "6fd9ed6962bf0a979a724e2672a4b261d77d73a8bfbef06f2a343780425e09c3"
    sha256 cellar: :any,                 arm64_ventura:  "edcb82580a8f78e18c33e334a2eda1e1ae6afeb206d0c58bc0a3cb17aa81d8f6"
    sha256 cellar: :any,                 arm64_monterey: "e6eee5a197c92ee6d04a1626be4173aae152d19c068ebe6dfcc401caf0e0e95b"
    sha256 cellar: :any,                 ventura:        "f3af25e8c0f1437101ed8ca706133538004a4020d99f76c2e763fc812ea89a76"
    sha256 cellar: :any,                 monterey:       "2358be694200117911918b09e3aab823a496704a3b7d48b6547509b636e8c206"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ff56c8d128c693ac61f0af6518ecd4f128beac9abdcd20b7ed90d1fd2277bbea"
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
