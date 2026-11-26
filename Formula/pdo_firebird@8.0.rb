# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT80 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5d85325de4b739456646af9ac824015bb250b293.tar.gz"
  version "8.0.30"
  sha256 "03b3915a8a35907eac68dd93013896677fc73c23f70cd538fdbd477098bd3481"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    manifest_sha256 "f7217e3beb6d766cea8dd41b5fa0d9b51d086e2637aa77f51207247cdd6e5a84"
    sha256 cellar: :any, arm64_golden_gate: "2cc34bc416b55b5aef72014011ef623f8aff175ae96e157cbd51e79b67b30d0a"
    sha256 cellar: :any, arm64_tahoe:       "6a107ac9da2bbdc23ad06b464ae7320f4efed39c3256d8e62eb5ebadfa2e6cfd"
    sha256 cellar: :any, arm64_sequoia:     "de2fe262df783679e6651b8257bc33329355f02e1af54358b3c3f8558fcb8f7d"
    sha256 cellar: :any, arm64_linux:       "e4548c57cd160f27a06886b9ffb293be5e5d3e8bf383af6277b4373ffea0a934"
    sha256 cellar: :any, x86_64_linux:      "0d7309740f0feec7b6ba72dcb27d08fa38768aeb28791fccc9c94844aeddb33d"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
