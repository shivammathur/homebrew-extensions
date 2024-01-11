# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.6.0.tgz"
  sha256 "417a0b39acebad34608d33ba88aa0ddc0849d45a7e4f107c1e8399f50a338916"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "77d46fd08026153e6a9488dcacab1dd945e4ec6596a8d54324921183765efe1c"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "46a3ff652efa0d3d48c2715a6d7baa8e3c870bf4bbc42813d5301794fbabe99c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c9a2add6def9bb41b346028c3508e8a9f3f4db33850078f276116cfd24ac1f26"
    sha256 cellar: :any_skip_relocation, ventura:        "e3e93679a5b05eb92c61b6648cab684d292e5a88ca38dd01230ef00000934887"
    sha256 cellar: :any_skip_relocation, monterey:       "226988c6ec817d42e447a21d4d2699ee7aae5e9df5dfbddf45b11aca542b82bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "629e50a8db39dcd123b668a8287f3199d3373480a6f7d9b735485ead983e5273"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
