# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT83 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.15.2.tgz"
  sha256 "fd8d3fbf7344854feb169cf3f1e6698ed22825d35a3a5229fe320c8053306eaf"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "6e9bfd325ed6b7c625509c6744fb39ad1e4be625d72836cd74a49290632fffb8"
    sha256 cellar: :any,                 arm64_sonoma:  "58d7ae47ca023fe7a95b076b8042f2f5aebe2734ba480565314ea4e54bbb3a7e"
    sha256 cellar: :any,                 arm64_ventura: "322b574371854f6979ada5e8fb056438db406cb5a8e35e2fe0c8e1e741e83d64"
    sha256 cellar: :any,                 ventura:       "6bac297fb1fd588a29470bcc0ebcfa7762f40cd923fc96da0a00a1d12bfdb976"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a2e23f394a85292ade73384a513f2587c5b2a52c6b2ef2043bdabec7b741879f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1ee12c8313d68e1eb52116782bcd825f4435bad25f81a4b7cad31bf0caa9a8d5"
  end

  depends_on "zstd"

  def install
    Dir.chdir "zstd-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-libzstd", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
