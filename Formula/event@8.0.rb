# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT80 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "abdf9dc2ded0d12dfa1903f4091bcdc6215ecf0d9c789b59aa653de5ddc96fbc"
    sha256 cellar: :any, arm64_sequoia: "3c3032e2570e2dbec00bba565f8660ce53bcb540ac2990ada81bdd0074aab343"
    sha256 cellar: :any, arm64_sonoma:  "1363dae67b65890135dfa613b1c3f8c988229a0388979c9f6e7ce0bac3eb86bf"
    sha256 cellar: :any, sonoma:        "290f8c064dd0ae247ebc0c0a0e952f7631cd710ea86da68d91cb7b710cc641ce"
    sha256 cellar: :any, arm64_linux:   "f900c6e58cbf0ed8aa921897ef4f37fe12a0793b86c871f7eb26e8f3bf7fe309"
    sha256 cellar: :any, x86_64_linux:  "7a92ca60cff154c81afa62f7088e432c38d252c909382296099163810abf969f"
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
