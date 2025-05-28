# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "c4f2deb4af928427477c13bd6eb142aa05fe27db6fbd2d6fb5c04744b89fd3ce"
    sha256 cellar: :any,                 arm64_sonoma:   "b9c3f2d4903725e8f5317aa776dd389e34a438e492dd41d5e75608c8b5658803"
    sha256 cellar: :any,                 arm64_ventura:  "81202f296dbb39e974053f57f1a053c244caade96278d5acecba65422ec7139b"
    sha256 cellar: :any,                 arm64_monterey: "60fbace595ee0ff518891366038f319f1ce62a55e7e0d8a7f28adaf363fb884a"
    sha256 cellar: :any,                 ventura:        "05807708e0090e365de76e6bb47ec49ca5bdaca7e0a2a3c740eb4fb21edeac82"
    sha256 cellar: :any,                 monterey:       "95a7df1af49d79ee2b868de6ed09bea27c9a685e645d96701d182c38d2194c09"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "dc682275da8862a2219a91a3c56759ab4e76d2939f3eac00ab91d7be089a1115"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "42de87261736956f5c6850b168f3e874597484af07ec7090457e377f4c256ba5"
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
