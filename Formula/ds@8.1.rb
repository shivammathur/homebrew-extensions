# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT81 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.8.0.tgz"
  sha256 "19abac84376399017590e11c08297e6784e332ec7eb26665a55f8818333d73c0"
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "15bcaa7b1199c42bc838e166f384286375f17666dd1eb544c13d0cfd123b953f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "11aeaaecf13fe6915181b84d59f5f48da949bfc9d0903d373603ff0e09960d43"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "45099eacf7fa42edb7ff2ff5c6344d75e5da63d576eaef7cda654122807f402c"
    sha256 cellar: :any_skip_relocation, sonoma:        "231cd733da77289b7077c2bbcda9b1afe2e9cfd59719f49dc648f5ca5d13ceb6"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "138dcfe9240038cbcfd3b45b5549fa06fdbb27e333db1c947f92bf0ddc5e49c2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "46c9fca80e5f299c2d88a3029b3c2f3d2c5efbee73fd868b6a86a1f157930ac8"
  end

  def install
    Dir.chdir "ds-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
