# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "67aedc0f97709cfe2f6eb4522d8e8b0eb0bcd19fbcadcb5f60b6b82e9f98b34d"
    sha256 cellar: :any,                 arm64_sonoma:   "74d43bb263fb459b14fd5c50309789728aa56ee4a9c163e4a349c8549922f1e2"
    sha256 cellar: :any,                 arm64_ventura:  "a9eb1417da6f31a5a8424be54dbc659c0c5f0bebabc4c353d0d89f8c8624d76b"
    sha256 cellar: :any,                 arm64_monterey: "43389e01e0bee805661dfa111d6d5ed97a9017cd0fcf6e64c9c7546b5916f684"
    sha256 cellar: :any,                 ventura:        "542b58154ad229bb6ca2cd07df4326e5b17fc71b3122e4578c0deafc901c89b5"
    sha256 cellar: :any,                 monterey:       "770d1331d08ebf77caf79766c707839eb4e8e9cb5d386b336723fa5c2ec597b7"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "2a3bfa0ff879f5a883afb375f3059b97ad4b4d9b98d76e02b465a7a1afad8eb6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "61b62952c14f921f8036ae5b7095c87bc15b82e99b31193349d0a1c3fc73c4a1"
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
