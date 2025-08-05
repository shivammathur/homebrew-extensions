# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT80 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.26.tgz"
  sha256 "aed8d359d98c33723b65e4ba58e5422e5cf794c54fbd2241be31f83a49b44dde"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a13c4d374852c6687bfaefeaa69823e63f7a204ab0eeb0cba9a0523e0a3297e2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ebb6388a3916142683b322c70bf2b76d65179a09aaeab0ce5deb0f6f56f7b8dd"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c37c8bffba39c4ff4d9270d7b42d805bac46ff846d060f4f5c192d3b70805d9e"
    sha256 cellar: :any_skip_relocation, ventura:       "74d86249dc15ec3313b50c402f6713d9f37e88743897a963b6e54b0e62e10170"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2d8d1b70d16d68a5ff08ce1ffe0347ff82fd46546281674a46cda7f3967329fe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6ea73df23bedd94332e57e666fa771d51a4bce356b83afad8899504dbfeba8eb"
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
