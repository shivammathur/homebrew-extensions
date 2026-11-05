# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT70 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "c308749af9ea513f117098b3877105afea2d752f2edde3afe1715b7072488345"
    sha256 cellar: :any, arm64_tahoe:       "a5ca6b5558e85efe621f9eaa4c4979ba6e244d4b4c3734eab10d77cba7b3c6d4"
    sha256 cellar: :any, arm64_sequoia:     "4f3c36398fab978a5f6ad73f1605a814d59f4804ed5d5697f64d18bc93ced32b"
    sha256 cellar: :any, arm64_linux:       "7ea6d387a71cf94891325db99ba7378651ccc3a16d3d349377dbaea17e28f667"
    sha256 cellar: :any, x86_64_linux:      "dc6eb7f6d45f5b9890cd91bf92774c4ea7aebd8442219cbf66d089a589274bb0"
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
