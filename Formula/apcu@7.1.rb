# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT71 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.24.tgz"
  sha256 "5c28a55b27082c69657e25b7ecf553e2cf6b74ec3fa77d6b76f4fb982e001e43"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "542bb30a24dc81eae8dd68657b4c6a21426fb0bc3d3a747a136b758931fd73a5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "ff0480112a7946daf876c9d6bf6ac0fb10b4f7ea3049ba3797f6ab1a3244eb55"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "7e81c342baf08519810db21e47e6c31b5da6741fd8dcc8a9ced078585b47be7f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "33c9cd576bc6881cec968ab0c67cf1b53925dba8c0091cb4c9983f0dc3df5b50"
    sha256 cellar: :any_skip_relocation, ventura:        "bfa8c302621c3000f0ceacd832190cfb344146e401aea48fedf26a845a63e612"
    sha256 cellar: :any_skip_relocation, monterey:       "69a6ee5351b18edcb960170073a400589c1e2e06ae3f873440a144508326dc6e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d19222b8487814cc3e548f4d9e3d57d08a2c2a282ecbcc9ac75054f673857348"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
