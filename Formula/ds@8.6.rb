# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT86 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.6.0.tgz"
  sha256 "7c5eaa693e49f43962fa8afa863c51000dc620048dcf9442453c27ca151e291e"
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "abb5c06244f37410e2701b6be4a01d2ae05d0df64f1d870b1beab1d0a41d78da"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ed4564886ad91aacd9b182ca2abcd15ec01621f90135b86f7292c57e505269a7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8e6bc9320275d0325b8e5379dd86668b42c78d5cd23ef9af4d540b0c7f704d43"
    sha256 cellar: :any_skip_relocation, sonoma:        "f90a6cd9bb0ed0f0c04bcef6d204523e408116db976c136b942de1b60a4b7219"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "24d0a24cd4cc5158b986beede1ff473908fbe7210337dc0a49f4ae148c43b567"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f2eed43a0b819d5f76445663a57316f69e5a368241757aa412389de63e18cedf"
  end

  priority "30"

  def install
    Dir.chdir "ds-#{version}"
    inreplace "src/common.h", "fast_add_function", "add_function"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
