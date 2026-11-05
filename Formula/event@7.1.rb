# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT71 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.2.0.tgz"
  sha256 "fb3d4e3c9fdc79125274f2b46461492923edec6b489ed7077973f7e65f41dc1c"
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/event/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "57a3fecf451109debed2b292368eee89be8159022b5d038758d90e5094eed588"
    sha256 cellar: :any, arm64_tahoe:       "6df2910f3fb02006e69467f55d7e1bbe8255a3ecb179d2451fb23de4e57fa95e"
    sha256 cellar: :any, arm64_sequoia:     "706531bbc261afdc1c739f7544bc5b44258180069a07f79363f0116bba737590"
    sha256 cellar: :any, arm64_linux:       "58c1073950d8b0ae48adb8764b3cd9ee18ec852d8bb9287dfd87710ce2e4c79c"
    sha256 cellar: :any, x86_64_linux:      "443800f0d46e0c010abff4fbec86f8d8b53cc0ed731168d04a2e18025fc57f7e"
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
