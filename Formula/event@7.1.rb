# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT71 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "1d9348ce4268370a80fb9ba3039b30ccd775a0f82c52828c62193d6ac7f0f67a"
    sha256 cellar: :any, arm64_tahoe:       "eb6f8cf8ba3218b4e59d8bd1ae1841d0e34596141ea62f4cff423bb113462d6d"
    sha256 cellar: :any, arm64_sequoia:     "082d0fb79ced12c47a0647ba5b9dca5ec3eff44e0c3e8f9b9545d2cfedec90d9"
    sha256 cellar: :any, arm64_linux:       "1c730085cfabc6dfdad6cb05132ee6ab8009630a9335ab816ece92130c740d0a"
    sha256 cellar: :any, x86_64_linux:      "96f856a7e36d4c64a0fc56a2849233cffa354b0f5bc85f863d0ff63f7e6a850a"
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
