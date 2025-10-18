# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "66e03918fec09712cb659f69f0425ad0ea3936c3256326fbc4756a0682ff9a50"
    sha256 cellar: :any,                 arm64_sonoma:   "d180c8b2a5ca5d0f10ff6479668bb1b71f168c3ed3f7c5f3c87edd18a2fea9f0"
    sha256 cellar: :any,                 arm64_ventura:  "8734e212edf4cc7aebcf7d004934a331637f0288b636fcdb45cad07a4ce9ce95"
    sha256 cellar: :any,                 arm64_monterey: "680dbf934e6b72900e551fe3d295dd475954ee7b201c7358fd815669b43d66ba"
    sha256 cellar: :any,                 ventura:        "85843970b8f1b0cb967c0be516eaa3c687d4253b253a2b7446bc509eec1c2ff8"
    sha256 cellar: :any,                 monterey:       "d50cd1a124f708edd74db3265801fd8ba8d147c7130968baf0c20ce855272c14"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "172c872879173a5ffe29f8601a6cae6740d49e7fb62096bb68f9914b80b53945"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6a1f496eea17254e918eb313f5f62e15e2aea4247951a5ec1d4e12477ea26979"
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
