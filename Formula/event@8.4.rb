# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT84 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "d554ddf909b44a40e28cb37756aacb5cea567fca0c518e401f73f795dfa61d5c"
    sha256 cellar: :any, arm64_tahoe:       "f3b565f37a26ed2b9447a88d46061fdb6f13f1c502687d4a2bfc378590260a41"
    sha256 cellar: :any, arm64_sequoia:     "b683be0adacab4058d6f182d44f42ba82085b36712c08dfc2a4c3116289bcb80"
    sha256 cellar: :any, arm64_linux:       "14cc310f773b247f9c62a738c6e250f3b615970e8f457fefef7a0b4c7b0e0be3"
    sha256 cellar: :any, x86_64_linux:      "97fcf8587d40161f2f84a1bf704257fd5be39e76690064b1718a0cfbbbfedf44"
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
