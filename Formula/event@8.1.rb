# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT81 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "71594b907e4bc0412300427180d066fb24a012ad753b23b93cd3d2874160bc40"
    sha256 cellar: :any, arm64_tahoe:       "90aa6e8c3143b7eda9d5f21e3bddacf4c8d15efeed86b9a15b3c71ca7d0a39b6"
    sha256 cellar: :any, arm64_sequoia:     "6fe97004409feb2d5198d1392363af3ed0b3813a8afdcbdb884dc62b58217029"
    sha256 cellar: :any, arm64_linux:       "1c859d2b48368bfb4d941089038ee8324acc19e90195c045bf5576d0f149f257"
    sha256 cellar: :any, x86_64_linux:      "5b342eace1699da3d84ede4bfe3adefcd5f8885ab77dea54193c77167a2acc46"
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
