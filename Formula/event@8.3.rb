# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT83 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "a6dd9bf1140add6f9c85e41d0e61902214ff5dfc3b98b1c17e7febe157f2fdce"
    sha256 cellar: :any, arm64_tahoe:       "95439a499a58579daab35e00a4c12d98156e103fa970a03dc97d5c71df011a64"
    sha256 cellar: :any, arm64_sequoia:     "fc997ece178e15b86f08783ec8057900de518224414907e79357bc82b15f7508"
    sha256 cellar: :any, arm64_linux:       "036934adc13e6351c414127ee65793aecd63c2d951e6b70a60fd3afacaacf7fd"
    sha256 cellar: :any, x86_64_linux:      "afbd30ff7896c0c59e053e53c117e0128738ef8a51224c9444d2117f16d97c3b"
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
