# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT72 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0.tgz"
  sha256 "82aa1e404c5ff54ec41d2a201305cd6594ed14a7529e9119fa7ca457e4bbd12a"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "f40df6c7a849d0061af7647630734812502c7a4e1e3c78df5f50680a3ce71e09"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "9046c27ebb8a09dc8e43ae4abebc4ca4fca3b45ba3767f1e98188fd3df245671"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "f5ceb720e7545ea53f9f324a811de141ecd98be2a5360885c4a2ae93a64dc78f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "29e11b8ceea42c632cda988ce3987010d1c07109ffb0602c01844790e6e3072a"
    sha256 cellar: :any_skip_relocation, ventura:        "bb96e3e4d79d4b6fead719a4086569cf9763c350803430cb00b4f648f7fa6274"
    sha256 cellar: :any_skip_relocation, monterey:       "e66a4380118c73ff9d790c4f5ec8de6ff532ca8a1888e5a43ce0cf555a1dbb23"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "279457c58243998934973b9dd4eb1a8011f5848cca1252d37447a3fc9ab056c0"
  end

  def install
    Dir.chdir "msgpack-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-msgpack"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
