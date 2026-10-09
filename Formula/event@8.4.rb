# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT84 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "1fe761baac6fc65f9d4dc946aa026c77144e9b7ff6ab74257ebee823a37ac49f"
    sha256 cellar: :any, arm64_tahoe:       "72c4032a2977fe46681fd48f44f76cc9aee7b58c105b9e68c7741221a02e393f"
    sha256 cellar: :any, arm64_sequoia:     "0ef2182029f00c590cb012ab20f5aa914e1a88a057b36959d94a59f82881c65d"
    sha256 cellar: :any, arm64_linux:       "81bd4e1a5c8c5d5f9c7e545120d384e23d50ea5bc94dc20082e63abee887ccc2"
    sha256 cellar: :any, x86_64_linux:      "ca860d18c1ed46beb798e10ecbf8cdb9c74147b4a9f98f424297d566a73710c8"
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
