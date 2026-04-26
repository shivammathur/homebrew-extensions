# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT86 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.28.tgz"
  sha256 "ca9c1820810a168786f8048a4c3f8c9e3fd941407ad1553259fb2e30b5f057bf"
  revision 1
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "eaee4f65adc9610755b938692aaf38f6a513f26497e9d91bb47451f88eb9f187"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5d627fc2b44b04a0ef0d6221a7643325dac81e484ca8927c615a20fdfedb1abd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "444266c963fc2a57986a03206384206b064427b087414f9b6f56210a0b296038"
    sha256 cellar: :any_skip_relocation, sonoma:        "7c3fcffe87d730d8d07f5c4ea1dd9ac621a3c9ed677b0e4e5ae1bae220c75ba1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "096a15c7c1264d4a641d0978ebb32b28a44d5230b0a5fd166d2cc759da4e4ac4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d2b6263d6bd1ad34023b7bdc99a5456f7c55ee3f66ba25d09ec51895f9005bb7"
  end

  def install
    Dir.chdir "apcu-#{version}"
    inreplace "apc_persist.c", "EMPTY_SWITCH_DEFAULT_CASE()", "default: ZEND_UNREACHABLE();"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
