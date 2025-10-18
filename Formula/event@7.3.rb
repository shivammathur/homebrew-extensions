# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "818bcc71a266449b29ed9ca410ad63644b1dccd425c5b02d17914ff62d83e240"
    sha256 cellar: :any,                 arm64_sonoma:   "1c2c7c5014a2584be6a6928cc8330acdb49723ee4fd11d70984fda6ece0c6eeb"
    sha256 cellar: :any,                 arm64_ventura:  "d040f2eea815bc46af347e2ac3eb08af0fd0e6233acaffd8ff287c772cfcb9a5"
    sha256 cellar: :any,                 arm64_monterey: "d3636f699bf85879e60188f68da704683c8622b990d836e6e3b50bcccc18f9ac"
    sha256 cellar: :any,                 ventura:        "27f70892e50cbf8d280bac9648785c0ce37f9e971e99a24ac3b8597766063e8a"
    sha256 cellar: :any,                 monterey:       "4223d3e8da3ebc43692cb6baa40860b67ac9b1fc728e4b57bbaa811172c2da2b"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "85d207efe150c19ac85d915647c126563e26cdcce4f875ba20e75d804460a5f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3a8d140e281c68b651d731008421957a36e7ef72168e77c8b4b8b9a8ddd2ec02"
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
