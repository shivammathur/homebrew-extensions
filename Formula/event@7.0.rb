# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT70 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "8db349445ef658c7cdf570b292bab1c875734a3ac87be5ce948295f0d573ae6a"
    sha256 cellar: :any, arm64_tahoe:       "302d59eb7843d91ec3a71d4e4e5f1583ea3daf6901fe4fedde1d9162ffc1e598"
    sha256 cellar: :any, arm64_sequoia:     "ca77112874c18aaf4643ff7cc5fc034960dc0a7f180555cf13479ab4f5e66730"
    sha256 cellar: :any, arm64_linux:       "3dcec6bea38509dfc6eb39f0238345d996f803ec93e4803b49b76f3dbf76e7c3"
    sha256 cellar: :any, x86_64_linux:      "2d1de97d872d2300e264f2636c9ff36acf73c537f1cc499be4d38cf61be4c2dd"
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
