# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT82 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "2e8e3f221d71d8fb73cca908b1dffc9328b1e62326687253e6b93cc9fb7a98af"
    sha256 cellar: :any, arm64_sequoia: "d76bd16dfb91c1ad48768a1251412717f513829c03cf15d1d505b7e6e3943713"
    sha256 cellar: :any, arm64_sonoma:  "1f84c806124ab9ea2b273ac93c3d04140e7386b418c55841eaa67e501439ee10"
    sha256 cellar: :any, sonoma:        "616d149b120f36dc7a21a8e48d11696140ff28d5a724bbfb91151a329414ef71"
    sha256 cellar: :any, arm64_linux:   "94aa7d03d9a5e614486abe41bc6c0de70a175d4f4b49ef281d8ca6556bb5f233"
    sha256 cellar: :any, x86_64_linux:  "67734f10b8e7b906e8e7d1342257f04b7428bc1f973252243dd5e2a3140f46fb"
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
