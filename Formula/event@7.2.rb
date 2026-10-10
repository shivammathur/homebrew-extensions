# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT72 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.6.tgz"
  sha256 "5b74554c6370aae8c284c8110fe27e071d3f663953c3eb762ffc429b0a3c83a2"
  revision 1
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/event/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "fcf4a211a7e9ec7dd27a8569d3112ba27bcf2bd6a679502be9be8383f1dbbc68"
    sha256 cellar: :any, arm64_tahoe:       "fda86d9b019546ee66ac542cf1784170bf163c88cb7ee67bc9e2e182f52c99cb"
    sha256 cellar: :any, arm64_sequoia:     "7d849ffef6ff79c548ec7c4b5fc83ccc58d649f92198e76d034ca31c3a5ca64e"
    sha256 cellar: :any, arm64_linux:       "f3a1d49d54540bc25f012878b02633e3680af2424e25c6f9906ffcac69563734"
    sha256 cellar: :any, x86_64_linux:      "a644d9770bdcac5a546551b23e0bf8f655eb7c41846a671d03b2f00c270e3359"
  end

  depends_on "libevent"
  depends_on "openssl@4"

  def install
    args = %W[
      --with-event-core
      --with-event-extra
      --with-event-openssl
      --enable-event-sockets
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@4")}
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
