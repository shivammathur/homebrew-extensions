# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "d9e9be83f922dc4af3daa5ccfb834b1097946ceabbf5ab450d52a3fedbe59e44"
    sha256 cellar: :any,                 arm64_sonoma:   "b7e044365516db007f9c378a94c915fb70be639a78315f4d515951dbf92a1d03"
    sha256 cellar: :any,                 arm64_ventura:  "cd465b3f3d0194c13ba6a5cf1a9725af42fa0ba94a3119b2b4b4f04ab98a73c2"
    sha256 cellar: :any,                 arm64_monterey: "68c2dd9b53b88f96a83b06ae1c18863ef800b73000234143b9a08099bb264bf2"
    sha256 cellar: :any,                 sonoma:         "518df47ef0b7e12c1542bcd572d1b0055db23046d8eb36fcc541762b94f3acec"
    sha256 cellar: :any,                 ventura:        "f6ce5358d03b4d9e12db967f79eefaa2bfd9b721df8050c9b81c32ca4470373b"
    sha256 cellar: :any,                 monterey:       "b669c9cc8f7d06c2e932fc6d0b45c526e9d4fe829a98a50af98a17e38a881b00"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "b09661143a08d5029024bb4cee5d79526e78f01ed03149176de5a4bebefa16f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0dc63a842f1c7dae134543e1ec601c168a072e17eaa05b70c5ee200a96485e95"
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
