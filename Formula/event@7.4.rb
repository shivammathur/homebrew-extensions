# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT74 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "6012996d7177fc34002fd52f351e81d4b9541058d64a3095f26d4ebb2a158694"
    sha256 cellar: :any, arm64_tahoe:       "db520aaaf924c1c089213cdacfd8d95fa35d2bcafa0807a5f1bef1f02fa386c1"
    sha256 cellar: :any, arm64_sequoia:     "b6fb1f11728646c5248b55342519bb7dc2091333c420516e0fc6390e5aac8b43"
    sha256 cellar: :any, arm64_linux:       "e74a0e5e5b3c30a1a74e6b28a4d9eb2844cbfc42f4eb2f469b6a3d6ac15d48b1"
    sha256 cellar: :any, x86_64_linux:      "4c0224cbb84bd4bb00f24eabb2c7209c65ad58b45caa970286f8ba66efd28859"
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
