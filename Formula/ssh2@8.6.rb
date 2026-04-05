# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT86 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.5.0.tgz"
  sha256 "a943427fae39a5503c813179018ae6c500323c8c9fb434e1a9a665fb32a4d7b4"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "c377f04ee9e206da1a82c55a72c1e05efb99f1ce3aa1ef1a4f6b9510a45d5647"
    sha256 cellar: :any,                 arm64_sequoia: "e3e18daa613d4be0c34fefe8f0053f122d47c6820cb8970314b2efdd6701768e"
    sha256 cellar: :any,                 arm64_sonoma:  "d877306f89aa170b57dc87a7f3afd552ac63b95368ea0308ad3877d5e1d9ce26"
    sha256 cellar: :any,                 sonoma:        "4a8d71025d37f121bf586c0f55687d83e9f971de8e90f0cbd28dcfa4db36115e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "734817039c501055ed5ff782a89b65862517ed42947eec2f38bf4fc31c8c7408"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "526fcda754a01edbe78e601a8ad5d40822dd1a01c4a1bc74968b09b84744eab1"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Formula["libssh2"].opt_prefix}
    ]
    Dir.chdir "ssh2-#{version}"
    inreplace "ssh2.c", "zval_is_true(&zretval)", "zend_is_true(&zretval)"
    inreplace "ssh2_fopen_wrappers.c", "zval_dtor(&copyval);", "zval_ptr_dtor(&copyval);"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
