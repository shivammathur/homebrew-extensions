# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT70 < AbstractPhpExtension
  init
  desc "Vld PHP extension"
  homepage "https://github.com/derickr/vld"
  url "https://github.com/derickr/vld/archive/0.18.0.tar.gz"
  sha256 "b6cd6165014bd8c1ddd8b473fc2e232a722c88226a52368c32555cc9cbfa71ed"
  head "https://github.com/derickr/vld.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "aca253d9c0ee9f042a8e32b9f4f49027b893a24710600540fa05baee417946da"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "aaaf4190e1435a473faf34d5152819ad0c0ca8cac85afcb294b0ba5c804a0415"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "19f49458578ba6a3e47f4ec7d89fe16928469bebfd59896d2c32303c7e4a30ed"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ddd275bfaec04edadcaf3a3df502e6c685555e92ccb9f6d6182cb1279e502dd7"
    sha256 cellar: :any_skip_relocation, ventura:        "775f4e108e60c0df29963cbf447ef85dfe6e9f5a1e04fb8dffe81103f11f36c5"
    sha256 cellar: :any_skip_relocation, monterey:       "d05ef32abc9e7cefe60a013edf03e301e126b1ce3fa8d5f2dbb673b710f2776d"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "cc1ae0d7934eb63e732ec28288c97fc9ba31d1828d2a3cdcf7d6072addf7a703"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "51a4082816a74cca0c9e75f30576cc02dc2db5908c858e0a8aadf365a3bbf3f6"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-vld"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
