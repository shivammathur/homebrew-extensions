# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT82 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.9.tgz"
  sha256 "ecb3d3c9dc9f7ce034182d478b724ac3cb02098efc69a39c03534f0b1920922b"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "34c02f320713893d5daa29028398a1716243d0d4e09870134aedd9fe119c8efc"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0a3f177a370e229a94635d3bb6fce5edeee73dcc7c1d9da9332187825be5918c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "00a78b868bc13099732ac7052cdc998ccefc8119dbc08e435b5bec06546d0d3c"
    sha256 cellar: :any_skip_relocation, sonoma:        "4dac94660e03b37805b7f6a2b61bb9e5c78ecd8e62a4acdda2c10e6107987d1d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "07f12f628f038a77fe7e117c375903e2d1f938333ae213c309c5224fcf991003"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5373a71ac6914132bf067ca2c03e41777a6bced70a156598d30edbde095955f0"
  end

  def install
    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
