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
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/event/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "8e7c919a29ab9c587d480e000230de2990da6362c65da08b3a3ef882c1881ff6"
    sha256 cellar: :any, arm64_sequoia: "f68340546fe4f9e80ad476c7d764c554d00c456bd41c830c59188fa28def74aa"
    sha256 cellar: :any, arm64_sonoma:  "47a1338eb50967fb1f70254f3e6c8a9dbf9c62d51037742282497677dee3caf1"
    sha256 cellar: :any, sonoma:        "63e14075c1d04552c157eb5d0129f3de60229b3f6df5fd3818b93efb9b366025"
    sha256 cellar: :any, arm64_linux:   "41b75abea7a74aa15144093876ea818618d197e12ffa329dd12ae288953dac2f"
    sha256 cellar: :any, x86_64_linux:  "a3424625dea433254d4ba7cfd33beed45cc27ed5e27804aa1f1cb8ed4754ff0c"
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
