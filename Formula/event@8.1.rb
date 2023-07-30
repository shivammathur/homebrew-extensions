# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT81 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.0.8.tgz"
  sha256 "e3e91edd3dc15e0969b9254cc3626ae07825e39bf26d61b49935f66f603d7b6b"
  revision 1
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "e0211dd675fc943d3e6e7fe06d2782bdbd2607c5317907ba20de2970e514a9f1"
    sha256 cellar: :any,                 arm64_big_sur:  "ab59c3a5e98f95bb5ecd1201209850cdada5a6d665bc3302ee43e8785e22ff91"
    sha256 cellar: :any,                 ventura:        "cdc29ca10326404953a848a7b43a6b726bfa624469f3e0cc6d6b767318520050"
    sha256 cellar: :any,                 monterey:       "7e944245c4e8fc7c96e83fbb509e6c05dcd1689699a9f0ac0c6d978f70857768"
    sha256 cellar: :any,                 big_sur:        "fc2169865a4121624e54fb4b9f1f5e3d44a57416b35fa0944a4090d4eff424bf"
    sha256 cellar: :any,                 catalina:       "a88cb1073dec03460560cb014243f4b2d10527690b57d12328ac7c587b0896c9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "91bfaea7fb418f4276b0a418b70aa8f7999874d1e53873bdaf1688a6a3381281"
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
