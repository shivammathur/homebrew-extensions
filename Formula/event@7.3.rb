# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT73 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.6.tgz"
  sha256 "5b74554c6370aae8c284c8110fe27e071d3f663953c3eb762ffc429b0a3c83a2"
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/event/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "244480436b57eeac57a6d656bae69295aed81558f871d0b4c1a47b9b32f5a6d4"
    sha256 cellar: :any, arm64_sequoia: "2ae900faab155cd34b03dff0d649aabacc1df6ba822c178b757547480bd2e247"
    sha256 cellar: :any, arm64_sonoma:  "7cfcb896569d92f1ef8b40e989d61ac9425e9b4e6ed0f19102803f7e0716d448"
    sha256 cellar: :any, sonoma:        "3d6331ef425a81c51a3d4a6cee4ecbadf12c02a54a153d5bc8929fb2b1d5d88d"
    sha256 cellar: :any, arm64_linux:   "5d4352c6412e40dbe270dea6c0c28060e59b343f232773c8f2f57bc4f45277df"
    sha256 cellar: :any, x86_64_linux:  "21720a9b385e2fc4487f8d845ca873615c13462e4fd2dddb94c0a45568be2c44"
  end

  depends_on "libevent"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-event-core
      --with-event-extra
      --with-event-openssl
      --enable-event-sockets
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@3")}
      --with-event-libevent-dir=#{Utils::Path.formula_opt_prefix("libevent")}
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
