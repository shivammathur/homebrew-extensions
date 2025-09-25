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
  revision 1
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/event/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "9801c480fb0801caf5cee63c4825e04a387f679e2d0a8a001b30b51c3010f700"
    sha256 cellar: :any,                 arm64_sequoia: "2a2972f32f323cb2383bebe5caa5706a73f1ffca62a94bda3e78f469ae4849e3"
    sha256 cellar: :any,                 arm64_sonoma:  "d28fbcfba45da84c7c0f2f7357478d2c1816e1ee9dcc62b23ed697e6a521c954"
    sha256 cellar: :any,                 sonoma:        "bb7ece6bcc683051b82883777196b30e574479dd9ec05683c5829b72e15326b7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "388fcda1ba449c27c472bd88e7279e1635241b485b619c68604d5a4d49ead89d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6a0944083d76ea8c19da197bf4fa105e56c70cd049b43266f729a8093cae55a8"
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
