# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "0143dca773a2d02d1afdb49ffc7ef3607f96cf8794d03796e8943d74e292fff4"
    sha256 cellar: :any, arm64_sequoia: "6ffed0bce0c30f6410c2f88f0f9940cc9e1a41dc6d1029f0681806c2a821e292"
    sha256 cellar: :any, arm64_sonoma:  "707b6d221fdca094d431640804622ca98c847a2d783bbc4c69e7aa5e69dac3db"
    sha256 cellar: :any, sonoma:        "4ff5a6444420493ae2d824dbcda0035ffca0dc5881e398437a4f332101ee3449"
    sha256 cellar: :any, arm64_linux:   "e904ee4248ed5610e2ebb48ad60600c17f71e593eff494f96a71fab9cdc70dc5"
    sha256 cellar: :any, x86_64_linux:  "09192304bc1a4ceba6011c371e54667ae18063e3f7f41ce8dd4ff6bbe03c9d3f"
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
