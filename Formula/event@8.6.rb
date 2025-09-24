# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT86 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.4.tgz"
  sha256 "5c4caa73bc2dceee31092ff9192139df28e9a80f1147ade0dfe869db2e4ddfd3"
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/event/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "6c2926ee98395a13d4f87eaafb7479ad3b16276ad8d413109217c45a5ddb2919"
    sha256 cellar: :any,                 arm64_sequoia: "6440dcff8d6e3a6ac53fe30affb73e84a2a397426b6e1b06d0a6cca1c05448fa"
    sha256 cellar: :any,                 arm64_sonoma:  "7f1bdb8f10da8b846a2078bb547dca566b1d2879017f88d6f6edcf4233532ad7"
    sha256 cellar: :any,                 sonoma:        "4d5ff81bfa45166c5e2f57f7c014362e92b7c03dd0f757a473f6cf24742ee050"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "379f1907d648c57d65d51d9ecc7e17d020096dea9c8cee5c2a138a92445d1788"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ad2babffe0d65897ec89744151b3f234f4635c18324d2229ed9734be64e82916"
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
