# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT87 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "8205c194ffb141c4e638ec875d031db2e223f0371fb52b4ab45aa9436fe350f9"
    sha256 cellar: :any, arm64_tahoe:       "aa1c760294f782f9405dd63e196bb029e1e123591bdf230c63157dfd8fcae01d"
    sha256 cellar: :any, arm64_sequoia:     "5797a6ac53863d16877cbb01042d4add661a701bcc9fd341493c2936a0dff708"
    sha256 cellar: :any, arm64_linux:       "53d4aaf5ff69c0374e46f1dd4e139039f370da217dbeab587002e41bda1dff0b"
    sha256 cellar: :any, x86_64_linux:      "fea5d2f278e3730e90a61e28fbc952106418c6140ce2851159990519b0d1a7c1"
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
