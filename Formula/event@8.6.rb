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
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "9e18b799320fd6994ff74ab390eb8e6a2ea6de83cc917fd4225f15c369792a4a"
    sha256 cellar: :any,                 arm64_sonoma:  "248e161ddf9a50d31d624a36d31e19f96c24412612740b60e3cdd31812af4605"
    sha256 cellar: :any,                 arm64_ventura: "79296a8ecf7372d0b1533a80e12d00dfdc18d7931fe03002c7c4c0874f406f4e"
    sha256 cellar: :any,                 ventura:       "2ab49628da9bb960194ea4c39ed3fa298470b04d25af225d490267fc192ad966"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "eea71c918386ace8ccb4c4c758f9bb8b9d13bb7cabd79ca47b7adaa6710765ef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4e27aefde679f462ae21fff0d4eadc9005cfa5b6c7e3765d15d9a5427866ea5e"
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
