# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT73 < AbstractPhpExtension
  init
  desc "Vld PHP extension"
  homepage "https://github.com/derickr/vld"
  url "https://github.com/derickr/vld/archive/0.19.1.tar.gz"
  sha256 "bfaf2ba7bdb11663bd9364096daa246fa4bfb1dec1eed9fa53ed9a8d5ed1f647"
  head "https://github.com/derickr/vld.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "50d0e199ce892c415e1edeed4f3b5c3f37a4d9cdee25de0bfeca6573d62c3e46"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f0faa8cd35b06cda3c618180a911488d628de5b3e2383160d491b9618903a2da"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "746fd108478a9e3dd306e78c98899fb79c73afc4d67b5c7dcd2123d7b340e22a"
    sha256 cellar: :any_skip_relocation, sonoma:        "3574817cebbfb5341c308c6c7d3f2cb7bc7de53ca79adb274d1e5c69a0cf53dd"
    sha256 cellar: :any_skip_relocation, ventura:       "c0e9330263660e4194c754fd0611bbd1d5242e64cfc612f36db23e5514939afe"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ffad7f0916c389a6c71c5cec85511277455d68e646f2c8d9e7aa3f4b655b3a57"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0083d7cae15249b493ac30429f93c3064f27aceb86167051c7352c2e7aa1203a"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-vld"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
